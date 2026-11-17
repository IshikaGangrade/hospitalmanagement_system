package entity;
public class Doctor {
	    private int id;
	    private String name;
	    private String email;
	    private String phone;
	    private String specialization;
	    private int experience;
	    private int departmentId;
	    public Doctor() {
	    }
	    public Doctor(String name, String email, String phone,
	                  String specialization, int experience,
	                  int departmentId) {
	        this.name = name;
	        this.email = email;
	        this.phone = phone;
	        this.specialization = specialization;
	        this.experience = experience;
	        this.departmentId = departmentId;
	    }
	    public int getId() {
	        return id;
	    }
	    public void setId(int id) {
	        this.id = id;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getEmail() {
	        return email;
	    }

	    public void setEmail(String email) {
	        this.email = email;
	    }

	    public String getPhone() {
	        return phone;
	    }

	    public void setPhone(String phone) {
	        this.phone = phone;
	    }

	    public String getSpecialization() {
	        return specialization;
	    }

	    public void setSpecialization(String specialization) {
	        this.specialization = specialization;
	    }

	    public int getExperience() {
	        return experience;
	    }

	    public void setExperience(int experience) {
	        this.experience = experience;
	    }

	    public int getDepartmentId() {
	        return departmentId;
	    }

	    public void setDepartmentId(int departmentId) {
	        this.departmentId = departmentId;
	    
	    }
		@Override
		public String toString() {
			return "Doctor [id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", specialization="
					+ specialization + ", experience=" + experience + ", departmentId=" + departmentId + "]";
		}
	    
	}

