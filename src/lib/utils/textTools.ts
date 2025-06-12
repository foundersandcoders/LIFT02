import type { TextFormat, TextSource } from "$lib/types/utilText"

export function makePretty(
  input: string,
  source: TextSource,
  format: TextFormat
):string {
  let output: string;
  switch (`${source} ${format}`) {
    case "table tile":
      output = toCaseTitle(cleanUnderscores(input));
      break;
    default:
      output = input;
  }
  
  return output;
}

function cleanUnderscores(text: string):string {
  return text.replace('_', " ")
};

function toCaseTitle(text: string):string {
  return text.split(" ").map(
    word => word.charAt(0).toUpperCase() + word.slice(1)
  ).join(" ")
}