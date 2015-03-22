package eonerateui.util;

public class Item {
	private Integer Id;
	private String name;
	
	public Integer getId() {
		return this.Id;
	}

	public void setId(Integer _Id) {
		this.Id = _Id;
	}
	
	public String getName() {
		return this.name;
	}

	public void setName(String _name) {
		this.name = _name;
	}
	
	public Item(Integer id, String name) {
		super();
		
		this.Id = id;
		this.name = name;
		
	}
	public Item() {
		super();
	}
	
	@Override
	public boolean equals(Object obj) {
	    if (obj == null) {
	        return false;
	    }
	    if (getClass() != obj.getClass()) {
	        return false;
	    }
	    final Item other = (Item) obj;
	    
	    if ((this.name == null) ? (other.name != null) : !this.name.equals(other.name)) {
	        return false;
	    }
	    if (!this.name.equals(other.name)) {
	        return false;
	    }
	    return true;
	}
	
}

