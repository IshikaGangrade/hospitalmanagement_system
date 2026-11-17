package entity;
public class Patient {
private int patientId;
private String name;
private String email;
private String phone;
private String gender;
private int age;
private String address;
private String disease;
private String blood;
public Patient() {

}
public Patient( String name, String email, String phone, String gender, int age, String address,
		String disease, String blood) {
   this.patientId = patientId;
	this.name = name;
	this.email = email;
	this.phone = phone;
	this.gender = gender;
	this.age = age;
	this.address = address;
	this.disease = disease;
	this.blood = blood;
}
public int getPatientId() {
	return patientId;
}
public void setPatientId(int patientId) {
	this.patientId = patientId;
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
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public int getAge() {
	return age;
}
public void setAge(int age) {
	this.age = age;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public String getDisease() {
	return disease;
}
public void setDisease(String disease) {
	this.disease = disease;
}
public String getBlood() {
	return blood;
}
public void setBlood(String blood) {
	this.blood = blood;
}
}
