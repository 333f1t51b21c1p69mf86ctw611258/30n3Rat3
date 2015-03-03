package eonerate.vnpcdrintegration.entity;

import java.util.Comparator;

public class ListItemComparator implements Comparator<ListItem> {

	@Override
	public int compare(ListItem o1, ListItem o2) {
		return o1.key < o2.key ? -1
				: o1.key > o2.key ? 1
						: 0;
	}

}
