$ErrorActionPreference = "Stop"

$python = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"

if (-not (Test-Path $python)) {
    py -3.10 -m venv (Join-Path $PSScriptRoot ".venv")
}

& $python -m pip install --upgrade pip --index-url https://pypi.tuna.tsinghua.edu.cn/simple
& $python -m pip install torch==2.11.0+cu128 --index-url https://download.pytorch.org/whl/cu128
& $python -m pip install -r (Join-Path $PSScriptRoot "requirements.txt") --index-url https://pypi.tuna.tsinghua.edu.cn/simple

& $python -c @'
import sklearn
import scipy
import torch
import numpy

print(f"Python: {__import__('sys').version.split()[0]}")
print(f"NumPy: {numpy.__version__}")
print(f"SciPy: {scipy.__version__}")
print(f"scikit-learn: {sklearn.__version__}")
print(f"PyTorch: {torch.__version__}")
print(f"CUDA runtime: {torch.version.cuda}")
print(f"CUDA available: {torch.cuda.is_available()}")
if torch.cuda.is_available():
    print(f"GPU: {torch.cuda.get_device_name(0)}")
'@
