# chotgpt.sh

A simple bash script to interact with OpenAI's ChatGPT using the OpenAI API.

## Description

`chotgpt.sh` allows users to quickly ask questions to ChatGPT and receive answers directly from the command line. It's designed with a focus on simplicity and ease of use.

## Prerequisites

- You need to have `curl` and `jq` installed on your system.
- An API key from OpenAI is required.

## Setup

1. Clone this repository or download the `chotgpt.sh` script.
2. Make the script executable:
   ```bash
   chmod +x chotgpt
   ```
3. Store your OpenAI API key in a file named `.chotgpt` in your home directory:
   ```bash
   echo "YOUR_API_KEY" > ~/.chotgpt
   ```

## Usage

To ask a question to ChatGPT, simply run the script followed by your question:

```bash
./chotgpt "Your question here"
```

For example:

```bash
./chotgpt "ffmpeg command. Convert mov to mp4 with h264"
```

The script will then display the answer from ChatGPT.

## Notes

- The script contains some predefined messages in Japanese, so it's optimized for Japanese language interactions. If you wish to use it for another language, you might need to modify the script accordingly.
- Ensure you handle your API key with care and do not expose it publicly.

## License

This project is open-source and available under the MIT License.

