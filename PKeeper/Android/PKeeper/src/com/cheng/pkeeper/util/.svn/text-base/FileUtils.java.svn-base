package com.cheng.pkeeper.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DecimalFormat;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

public class FileUtils {

	public static final String CACHEDIR = "mytext";
	public static final String CACHEDIR_IMAGE = "ImageCache";
	public static final String CACHEDIR_VIDEO = "VideoCache";
	public static final String CACHEDIR_IMAGE_TAKE = "Image";
	public static final String CACHEDIR_VIDEO_TAKE = "Video";
	public static final String CACHEDIR_IMAGE_SAVE = "BabyunSave";
	public static final String CACHEDIR_APK = "APK";
	public static final String CACHEDIR_HEAD = "HEAD";
	public static final String CACHEDIR_FILE = "File";
	public static final String CACHEDIR_CRASH = "Crash";

	public static String getCachDir(Context context) {
		String dir = getSDPath(context) + "/" + CACHEDIR;
		return dir;
	}

	public static File getImageCachFile(Context context) {
		return createFile(getImageCachDir(context));
	}
	
	public static String getImageCachDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_IMAGE;
		return dir;
	}
	public static File getCachFile(Context context) {
		return createFile(getCachDir(context));
	}

	

	
	/*
	public static String getVideoCachDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_VIDEO;
		return dir;
	}

	public static File getVideoCachFile(Context context) {
		return createFile(getVideoCachDir(context));
	}

	public static String getImageSaveDir(Context context) {
		String dir = getSDPath(context) + "/" + CACHEDIR_IMAGE_SAVE;
		return dir;
	}

	public static File getImageSaveFile(Context context) {
		return createFile(getImageSaveDir(context));
	}

	public static String getImageTakeDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_IMAGE_TAKE;
		return dir;
	}

	public static File getImageTakeFile(Context context) {
		return createFile(getImageTakeDir(context));
	}

	public static String getVideoTakeDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_VIDEO_TAKE;
		return dir;
	}

	public static File getVideoTakeFile(Context context) {
		return createFile(getVideoTakeDir(context));
	}

	public static String getApkCachDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_APK;
		return dir;
	}*/

	public static String getHeadCachDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_HEAD;
		return dir;
	}

	/*public static String getFileCachDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_FILE;
		return dir;
	}

	public static File getFileFile(Context context) {
		return createFile(getFileCachDir(context));
	}

	public static String getFileSecondCachDir(Context context, String name) {
		File file = getCachFile(context);
		String cache = file.getAbsolutePath() + "/" + CACHEDIR_FILE;
		File f = createFile(cache);
		String dir = f.getAbsolutePath() + "/" + name;
		return dir;
	}

	public static String getCrashDir(Context context) {
		File file = getCachFile(context);
		String dir = file.getAbsolutePath() + "/" + CACHEDIR_CRASH;
		return dir;
	}
	
	public static File getCrashFile(Context context){
		return createFile(getCrashDir(context));
	}

	public static File getFileSecondFile(Context context, String name) {
		return createFile(getFileSecondCachDir(context, name));
	}
*/
	public static File createFile(String path) {
		File file = new File(path);
		if (!file.exists())
			file.mkdirs();
		return file;
	}

	// 得到当前SDCard目录
	public static String getSDPath(Context context) {
		File sdDir = null;
		boolean sdCardExist = Environment.getExternalStorageState().equals(
				android.os.Environment.MEDIA_MOUNTED); // 判断sd卡是否存在
		if (!sdCardExist) {
			File path = new File(context.getFilesDir().getAbsolutePath());
			if (!path.exists()) {
				path.mkdirs();
			}
			sdDir = path;
		} else {
			sdDir = Environment.getExternalStorageDirectory(); // 获取根目录
		}
		if (sdDir != null) {
			return sdDir.toString();
		} else {
			return "";
		}
	}

	/**
	 * 得到文件夹大小
	 * 
	 * @param dir
	 * @return
	 *//*
	public static long getDirSize(File dir) {
		if (dir == null) {
			return 0;
		}
		if (!dir.isDirectory()) {
			return 0;
		}
		long dirSize = 0;
		File[] files = dir.listFiles();
		for (File file : files) {
			if (file.isFile()) {
				dirSize += file.length();
			} else if (file.isDirectory()) {
				dirSize += file.length();
				dirSize += getDirSize(file); // 如果遇到目录则通过递归调用继续统计
			}
		}
		return dirSize;
	}

	*//**
	 * 将文件大小long转换为String
	 * 
	 * @param fileSize
	 * @return
	 *//*
	public static String getDirSizeToString(Long fileSize) {
		double size = 0;
		size = (fileSize + 0.0) / (1024 * 1024);
		DecimalFormat df = new DecimalFormat("0.00");// 以Mb为单位保留两位小数
		String filesize = df.format(size) + "MB";
		return filesize;
	}

	*//**
	 * 删除文件
	 * 
	 * @param file
	 *//*
	public static void deleteFile(File file) {
		if (file.exists()) { // 判断文件是否存在
			if (file.isFile()) { // 判断是否是文件
				file.delete(); // delete()方法 你应该知道 是删除的意思;
			} else if (file.isDirectory()) { // 否则如果它是一个目录
				File files[] = file.listFiles(); // 声明目录下所有的文件 files[];
				for (int i = 0; i < files.length; i++) { // 遍历目录下所有的文件
					deleteFile(files[i]); // 把每个文件 用这个方法进行迭代
				}
			}
			file.delete();
		} else {
			System.out.println("所删除的文件不存在！" + '\n');
		}
	}

	public static void writeFileSdcard(String fileName, String message) {

		try {

			// FileOutputStream fout = openFileOutput(fileName, MODE_PRIVATE);

			FileOutputStream fout = new FileOutputStream(fileName);

			byte[] bytes = message.getBytes();

			fout.write(bytes);

			fout.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

	public static String readFile(File file) {
		String content = ""; // 文件内容字符串
		// 如果path是传递过来的参数，可以做一个非目录的判断
		if (file.isDirectory()) {
			Log.d("TestFile", "The File doesn't not exist.");
		} else {
			try {
				InputStream instream = new FileInputStream(file);
				if (instream != null) {
					InputStreamReader inputreader = new InputStreamReader(
							instream);
					BufferedReader buffreader = new BufferedReader(inputreader);
					String line;
					// 分行读取
					while ((line = buffreader.readLine()) != null) {
						content += line + "\n";
					}
					instream.close();
				}
			} catch (java.io.FileNotFoundException e) {
				Log.d("TestFile", "The File doesn't not exist.");
			} catch (IOException e) {
				Log.d("TestFile", e.getMessage());
			}
		}
		return content;
	}

	public static String readFile(String strFilePath) {
		String path = strFilePath;
		// 打开文件
		File file = new File(path);
		return readFile(file);
	}
	*/
	public static boolean hasSdcard(){
        String state = Environment.getExternalStorageState();
        if(state.equals(Environment.MEDIA_MOUNTED)){
                return true;
        }else{
                return false;
        }
}
}
