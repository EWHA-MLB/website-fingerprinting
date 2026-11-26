"""노트북을 실행하고 출력을 남긴 채 저장한다. 셀이 끝날 때마다 중간 저장."""
import sys, time
import nbformat
from nbclient import NotebookClient

src, dst = sys.argv[1], sys.argv[2]
nb = nbformat.read(src, as_version=4)
client = NotebookClient(nb, timeout=None, kernel_name="python3", resources={"metadata": {"path": sys.argv[3]}})
with client.setup_kernel():
    for i, cell in enumerate(nb.cells):
        if cell.cell_type != "code":
            continue
        t0 = time.time()
        client.execute_cell(cell, i)
        print(f"cell {i} done in {time.time() - t0:.0f}s", flush=True)
        for o in cell.get("outputs", []):
            if o.get("output_type") == "stream":
                print(o.get("text", "")[-2000:], flush=True)
        nbformat.write(nb, dst)
print("ALL DONE", flush=True)
