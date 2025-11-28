from flask import Flask, jsonify
import os

app = Flask(__name__)


@app.route('/')
def index():
    """Endpoint principal que retorna información básica de la aplicación."""
    return jsonify({
        'message': 'Base Image Hardening Benchmark',
        'status': 'running',
        'version': '1.0.0'
    })


@app.route('/health')
def health():
    """Endpoint de health check para monitoreo."""
    return jsonify({
        'status': 'healthy',
        'service': 'base-image-hardening-benchmark'
    }), 200


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
