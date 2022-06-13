@echo off
chcp 65001 > nul
if exist .\ffmpeg (
	echo [Info] ffmpegが見つかりました
	for %%f in (source\*) do (
	  echo %%~nxfを変換します
	  timeout 3
	  ffmpeg\bin\ffmpeg -i "source\%%~nxf" -vcodec libx264 -b:v 2500k "output\%%~nxf"
	  echo %%~nxfを変換しました
)

) else (
	echo [Info] エンコードに使用するffmpegをダウンロードします
	timeout 3
	bitsadmin /transfer "ffmpeg" https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n4.4-latest-win64-gpl-shared-4.4.zip %~dp0/ffmpeg-components.zip
	timeout 1
	echo [Info] ffmpegを解凍します
	call powershell -command "Expand-Archive ffmpeg-components.zip"
	del /Q ffmpeg-components.zip

	move .\ffmpeg-components\ffmpeg-n4.4-latest-win64-gpl-shared-4.4 .\ffmpeg
	rmdir /Q ffmpeg-components

	echo [Info] 動画配置用のディレクトリを作成しています
	mkdir source
	mkdir output
	echo [Info] セットアップ完了;
	echo [Info] sourceディレクトリに変換したい動画ファイルを入れて再度実行してください;
	echo [Info] 変換が完了するとoutputディレクトリに出力されます
)

pause