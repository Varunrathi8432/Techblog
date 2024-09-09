package com.techblog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class UpdateImage {
	public static void deleteFile(String path) {
		try {
			File file=new File(path);
			file.delete();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static boolean saveFile(InputStream inpst,String path) {
		boolean check=false;
		try {
			byte b[]=new byte[inpst.available()];
			inpst.read(b);
			
			FileOutputStream fout=new FileOutputStream(path);
			fout.write(b);
			
			fout.flush();
			fout.close();
			check=true;
			
		} catch (Exception e) {
			
		}
		
		return check;
	}
}
