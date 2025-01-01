#!/bin/bash

# 檢查是否提供輸入檔案
if [ $# -ne 1 ]; then
    echo "使用方法: $0 <輸入的srt檔案>"
    exit 1
fi

input_file="$1"
temp_file="temp_$$.srt"
output_file="sorted_${input_file}"

# 讀取檔案並將內容分割成區塊
awk '
BEGIN {
    RS="\n\n"  # 使用空行作為記錄分隔符
    block_count = 0
    counter = 1  # 初始化計數器
}
{
    if (NF > 0) {  # 跳過空區塊
        # 提取時間戳記
        split($0, lines, "\n")
        timestamp = lines[2]
        
        # 轉換時間戳記為秒數以便排序
        split(timestamp, times, " --> ")
        split(times[1], start, "[,:]")
        start_seconds = start[1]*3600 + start[2]*60 + start[3] + start[4]/1000
        
        # 儲存區塊內容和開始時間
        blocks[block_count] = $0
        start_times[block_count] = start_seconds
        block_count++
    }
}
END {
    # 使用氣泡排序法根據開始時間排序區塊
    for (i = 0; i < block_count-1; i++) {
        for (j = 0; j < block_count-i-1; j++) {
            if (start_times[j] > start_times[j+1]) {
                # 交換時間
                temp = start_times[j]
                start_times[j] = start_times[j+1]
                start_times[j+1] = temp
                
                # 交換區塊
                temp = blocks[j]
                blocks[j] = blocks[j+1]
                blocks[j+1] = temp
            }
        }
    }
    
    # 去除重複的時間戳記區塊並重新編號
    last_time = -1
    last_content = ""
    number = 1  # 重新編號的計數器
    
    for (i = 0; i < block_count; i++) {
        if (start_times[i] != last_time) {
            # 分割當前區塊內容
            split(blocks[i], current_lines, "\n")
            
            # 輸出新的編號
            printf "%d\n", number
            
            # 輸出時間戳記和內容
            for (j = 2; j <= length(current_lines); j++) {
                printf "%s\n", current_lines[j]
            }
            printf "\n"
            
            last_time = start_times[i]
            last_content = blocks[i]
            number++  # 遞增編號
        }
    }
}' "$input_file" > "$temp_file"

# 移動臨時檔案到輸出檔案
mv "$temp_file" "$output_file"

echo "排序完成！輸出檔案: $output_file"