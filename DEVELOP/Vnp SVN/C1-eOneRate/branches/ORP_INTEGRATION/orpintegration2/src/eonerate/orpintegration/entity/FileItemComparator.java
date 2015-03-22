package eonerate.orpintegration.entity;

import java.util.Comparator;

public class FileItemComparator implements Comparator<FileItem> {

	@Override
	public int compare(FileItem o1, FileItem o2) {
		return o1.key < o2.key ? -1
				: o1.key > o2.key ? 1
						: 0;
	}

}
