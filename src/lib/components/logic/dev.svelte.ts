let tileNum = $state(0);
export function setTileNum(num: number) {
  tileNum = num;
}
export function getTileNum(): number {
  return tileNum;
}

let listNum = $state(0);
export function setListNum(num: number) {
  listNum = num;
}
export function getListNum(): number {
  return listNum;
}