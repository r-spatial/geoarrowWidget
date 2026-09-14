import * as flatgeobuf from "https://cdn.jsdelivr.net/npm/@geoarrow/flatgeobuf-wasm/esm/+esm";

async function fgb2arrow(fgb) {
  await flatgeobuf.default();
  const parquetBytes = new Uint8Array(await fgb.arrayBuffer());
  const wasmTable = flatgeobuf.readFlatGeobuf(parquetBytes);
  const arrow_table = Arrow.tableFromIPC(wasmTable.intoTable().intoIPCStream());
  return arrow_table;
}

Object.assign(window, {fgb2arrow});
