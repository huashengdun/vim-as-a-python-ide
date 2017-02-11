import os.path
import subprocess
import sys


def main():
    virtualenv_path = os.environ['VIRTUAL_ENV']
    interpreter = os.path.join(virtualenv_path, 'bin', 'python')
    cmd = [interpreter, '-c', 'import sys; print(sys.path)']
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    out, _ = proc.communicate()
    sys.path = [p.strip(" \n[]'") for p in out.decode('utf-8').split(',')]


if __name__ == '__main__':
    main()
