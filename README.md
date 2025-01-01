# Sort srt base on timestamp
 
# Sort srt based on timestamp
 
A shell script for sorting and renumbering SRT (SubRip Subtitle) files based on timestamp order. This tool helps maintain proper chronological order of subtitles and eliminates duplicate timestamps.

## Features

- ✨ Sorts subtitles based on timestamp
- 🔢 Automatically renumbers subtitle sequences
- 🗑️ Removes duplicate timestamps
- 🛡️ Preserves original subtitle content and formatting
- 💾 Creates a new file without modifying the original

## Prerequisites

- Unix-like operating system (Linux, macOS)
- Bash shell
- AWK (commonly pre-installed on Unix systems)

## Installation

1. Clone this repository or download the script:
```bash
git clone https://github.com/yourusername/srt-sorter.git
cd srt-sorter
```

2. Make the script executable:
```bash
chmod +x sort_srt.sh
```

## Usage

Run the script with your SRT file as an argument:

```bash
./sort_srt.sh input.srt
```

The script will create a new file named `sorted_input.srt` in the same directory.

### Example Input:

```
2292
03:04:09,100 --> 03:04:10,466
Some text here
2293
00:00:02,000 --> 00:00:04,266
Earlier text
```

### Example Output:

```
1
00:00:02,000 --> 00:00:04,266
Earlier text

2
03:04:09,100 --> 03:04:10,466
Some text here
```

## How It Works

1. The script reads the input SRT file and splits it into blocks
2. Each block's timestamp is converted to seconds for accurate sorting
3. Blocks are sorted based on their start times
4. Duplicate timestamps are removed
5. Blocks are renumbered sequentially
6. A new file is created with the sorted and renumbered content

## Error Handling

- The script checks if an input file is provided
- Creates a temporary file during processing
- Preserves the original file
- Provides feedback upon completion

## Limitations

- Input file must be in valid SRT format
- Requires proper line endings (Unix style recommended)
- Time format must be standard SRT format (HH:MM:SS,mmm)