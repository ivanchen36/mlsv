import base64
import os

def extract_and_save_images(file_path, output_dir):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    current_key = None
    base64_data = []
    in_base64_block = False

    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()  # 移除行首尾的空白符

            # 查找文件名
            if 'tbl_bmps["' in line:
                if current_key and in_base64_block:
                    # 如果之前已经有数据在收集，先处理之前的数据
                    process_base64_data(current_key, base64_data, output_dir)
                    base64_data = []
                start_index = line.find('tbl_bmps["') + len('tbl_bmps["')
                end_index = line.find('"]', start_index)
                if end_index != -1:
                    current_key = line[start_index:end_index]
                in_base64_block = False

            elif current_key and 'value = [[' in line:
                in_base64_block = True
                base64_start = line.find('[[') + 2
                base64_end = line.find(']]', base64_start)
                if base64_end != -1:
                    base64_data.append(line[base64_start:base64_end])
                    process_base64_data(current_key, base64_data, output_dir)
                    current_key = None
                    base64_data = []
                    in_base64_block = False
                else:
                    base64_data.append(line[base64_start:])

            elif current_key and in_base64_block:
                if line.endswith(']]'):
                    line = line[:-2]  # 移除结束标记 ']]'
                    base64_data.append(line)
                    process_base64_data(current_key, base64_data, output_dir)
                    current_key = None
                    base64_data = []
                    in_base64_block = False
                else:
                    base64_data.append(line)

def process_base64_data(key, data_list, output_dir):
    # 将数据列表合并成一个字符串，并移除可能的换行符和其他空白符
    base64_string = ''.join(data_list).replace('\n', '').replace(' ', '')
    try:
        image_data = base64.b64decode(base64_string)
    except base64.binascii.Error as e:
        print(f"Error decoding Base64 for {key}: {e}")
        return

    output_file_path = os.path.join(output_dir, key)
    try:
        with open(output_file_path, 'wb') as image_file:
            image_file.write(image_data)
        print(f"Saved {output_file_path}")
    except IOError as e:
        print(f"Error saving {output_file_path}: {e}")

if __name__ == '__main__':
    # 使用示例
    extract_and_save_images('./out.txt', "./output_images")