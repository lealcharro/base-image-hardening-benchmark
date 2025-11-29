import json
import os
import subprocess
import datetime

def run_command(command):
    try:
        result = subprocess.run(command, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error ejecutando el comando: {e}")
        print(f"Stderr: {e.stderr}")
        return None

def parse_inspect_output(output):
    data = {}
    lines = output.strip().split('\n')
    
    # Omitimos línea de cabecera
    for line in lines[1:]:
        parts = line.strip().split()
        if len(parts) != 4:
            continue
            
        variant, size_mb, layers, user = parts
        
        data[variant] = {
            "size_mb": float(size_mb.replace(',', '.')) if size_mb != "null" else None,
            "layers": int(layers) if layers != "null" else None,
            "user": user if user != "null" else None
        }
            
    return data

def parse_cap_check_output(output):
    data = {}
    seccomp_status = None
    lines = output.strip().split('\n')
    
    for line in lines:
        if not line:
            continue
        
        # Se elimina el prefijo '>>>' 
        clean_line = line.lstrip('>>> ')
        parts = clean_line.split(':', 1)
        variant = parts[0]
        
        if variant == "seccomp_test":
            seccomp_status = parts[1]
            continue

        if len(parts) == 2 and parts[1] != "null":
            caps = sorted(parts[1].split(','))
            data[variant] = {"capabilities": caps}
        else:
            data[variant] = {"capabilities": []}
            
    if seccomp_status:
        data["seccomp_test_status"] = seccomp_status

    return data

def main():
    print("Generando reporte de benchmark:")
    
    print("Ejecutando inspect-images.sh...")
    inspect_output = run_command("./scripts/inspect-images.sh")
    if not inspect_output:
        print("No se pudo obtener la información de inspección de imágenes.")
        return
        
    image_data = parse_inspect_output(inspect_output)

    print("Ejecutando cap-check.sh...")
    cap_output = run_command("./scripts/cap-check.sh")
    if not cap_output:
        print("No se pudo obtener la información de capabilities.")
        return

    cap_data = parse_cap_check_output(cap_output)
    
    # Juntamos los datos en nuestro benchmark_data
    benchmark_data = {}
    seccomp_test_status = cap_data.pop("seccomp_test_status", None)
    all_variants = set(image_data.keys()) | set(cap_data.keys())
    
    for variant in all_variants:
        if variant not in benchmark_data:
             benchmark_data[variant] = {}
        benchmark_data[variant].update({
            "size_mb": image_data.get(variant, {}).get("size_mb"),
            "layers": image_data.get(variant, {}).get("layers"),
            "user": image_data.get(variant, {}).get("user"),
            "capabilities": cap_data.get(variant, {}).get("capabilities", [])
        })

    # Se crea el reporte final
    git_sha = run_command("git rev-parse --short HEAD")
    final_report = {
        "benchmark_timestamp_utc": datetime.datetime.utcnow().isoformat(),
        "git_sha": git_sha.strip() if git_sha else "N/A",
        "seccomp_test_status": seccomp_test_status,
        "variants": benchmark_data
    }
    
    # Se guardar el reporte en un archivo json
    if not os.path.exists("reports"):
        os.makedirs("reports")
        
    report_path = "reports/benchmark.json"
    with open(report_path, "w") as f:
        json.dump(final_report, f, indent=4)
        
    print(f"Reporte generado exitosamente en: {report_path}")

if __name__ == "__main__":
    main()
