import * as geoparquet from "https://cdn.jsdelivr.net/npm/@geoarrow/geoparquet-wasm/esm/+esm";

async function parquet2arrow(pq) {
  await geoparquet.default();
  const parquetBytes = new Uint8Array(await pq.arrayBuffer());
  const wasmTable = geoparquet.readGeoParquet(parquetBytes);
  const arrow_table = Arrow.tableFromIPC(wasmTable.intoIPCStream());
  return arrow_table;
}

Object.assign(window, {parquet2arrow});
