import * as fs from 'fs';
import * as readline from 'readline';

async function splitCsv(inputFilePath: string, outputFolderPath: string, chunkSize: number): Promise<void> {
  const inputReadStream = fs.createReadStream(inputFilePath);
  const rl = readline.createInterface({
    input: inputReadStream,
    crlfDelay: Infinity,
  });

  let lineCount = 0;
  let fileIndex = 1;
  let outputWriteStream = createWriteStreamForChunk(outputFolderPath, fileIndex);

  for await (const line of rl) {
    lineCount++;

    // Write the line to the current chunk file
    outputWriteStream.write(line + '\n');

    // If we reached the chunk size, close the current file and move to the next one
    if (lineCount === chunkSize) {
      outputWriteStream.end();
      lineCount = 0;
      fileIndex++;
      outputWriteStream = createWriteStreamForChunk(outputFolderPath, fileIndex);
    }
  }

  // Close the last file stream
  outputWriteStream.end();
}

function createWriteStreamForChunk(outputFolderPath: string, fileIndex: number): fs.WriteStream {
  const outputFilePath = `${outputFolderPath}/chunk_${fileIndex}.csv`;
  return fs.createWriteStream(outputFilePath);
}

// Example usage
const inputFilePath = "tasks/data/MDUS.csv";
const outputFolderPath = 'tasks/output';
const chunkSize = 10000;

splitCsv(inputFilePath, outputFolderPath, chunkSize)
  .then(() => console.log('CSV file successfully split.'))
  .catch((error) => console.error('Error:', error));
