import os


def renameBmpFiles(directory, path):
    # 确保传入的directory是字符串且存在
    if not isinstance(directory, str) or not os.path.exists(directory):
        raise ValueError("The provided directory is not valid.")

    # 遍历指定目录下的所有文件
    for filename in os.listdir(directory):
        # 检查文件是否以.bmp结尾
        if filename.lower().endswith('.bmp'):
            # 构造完整文件路径
            filePath = os.path.join(directory, filename)

            # 检查文件名是否以jm_开头
            if not filename.startswith('jm_'):
                # 如果不是，则在文件名前添加jm_
                newFilename = 'jm_' + filename
            else:
                # 如果是，则保留原文件名
                newFilename = filename

            # 检查文件名是否包含"画板 1"
            if "画板 1" in newFilename:
                # 如果包含，则删除这个字符串
                newFilename = newFilename.replace("画板 1", "")

            # 检查新文件名是否与旧文件名不同
            if newFilename != filename:
                # 如果不同，则重命名文件
                newFilePath = os.path.join(path, newFilename)
                os.rename(filePath, newFilePath)
                print(f"Renamed '{filename}' to '{newFilename}'")

if __name__ == "__main__":
    renameBmpFiles("../psd/", "../client/image/")