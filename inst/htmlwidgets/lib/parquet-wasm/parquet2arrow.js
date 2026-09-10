import * as parquet from "https://cdn.jsdelivr.net/npm/parquet-wasm/esm/+esm"

async function parquet2arrow(pq) {
    await parquet.default();
    let parquetBytes = new Uint8Array(await pq.arrayBuffer());
    const wasmTable = parquet.readParquet(parquetBytes);
    const arrow_table = Arrow.tableFromIPC(wasmTable.intoIPCStream());
    return arrow_table;
}

Object.assign(window, {parquet2arrow});
