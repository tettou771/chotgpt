#!/bin/bash

CONFIG_FILE="$HOME/.chotgpt"

# APIキーを~/.chotgptから読み込みます
if [[ -f $CONFIG_FILE ]]; then
    API_KEY=$(cat $CONFIG_FILE)
else
    echo "設定ファイルが存在しません。"
    echo "$CONFIG_FILE にAPIキーを書いて保存してください。"
    exit 1
fi

# コマンドライン引数から質問を取得します
# すべての引数を一つの文字列として結合します
question="$*"

# プロンプトの定型文を設定します
messages_json="[{\"role\":\"system\",\"content\":\"You are a helpful assistant.\"},{\"role\":\"user\",\"content\":\"簡潔に1行で回答してください。質問の内容: $question\"}]"

# 質問をChatGPTに送信し、回答を取得します
response=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{\"model\": \"gpt-4\", \"messages\": $messages_json, \"max_tokens\": 1000, \"n\": 1, \"stop\": null, \"temperature\": 0.5}")

# エラーメッセージが存在する場合、それに基づいてエラーコードを設定します
if [[ $(echo "$response" | jq '.error') != "null" ]]; then
    status_code=$(echo "$response" | jq -r '.error.code')
else
    status_code="200"
fi

# エラーハンドリングを行います
parseErrorResponse() {
  case $1 in
    "200") echo "SUCCESS" ;;
    "InvalidAPIKey") echo "InvalidAPIKey" ;;
    "ServerError") echo "ServerError" ;;
    "RateLimitExceeded") echo "RateLimitExceeded" ;;
    "model_not_found") echo "InvalidModel" ;;
    "too_many_tokens") echo "TokenLimitExceeded" ;;
    "BadRequest") echo "BadRequest" ;;
    "Timeout") echo "Timeout" ;;
    *) echo "UnknownError (Status Code: $1)" ;;
  esac
}

error_string=$(parseErrorResponse $status_code)

if [ "$error_string" == "SUCCESS" ]; then
  # 回答を表示します
  echo "$(echo "$response" | jq -r '.choices[0].message.content')"
else
  echo "ERROR: $error_string"
fi
