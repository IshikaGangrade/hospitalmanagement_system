package entity;

public class Appointment {
    private int id;
    private String appointmentDate;
    private String appointmentTime;
    private int patientId;
    private int doctorId;
    private String patientName;
    private String doctorName;
    private String status;
    public Appointment() {
    }
    public Appointment(String appointmentDate, String appointmentTime,
                       int patientId, int doctorId) {
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.status = "Pending";
    }
    public Appointment(int id, String appointmentDate, String appointmentTime,
                       int patientId, int doctorId, String status) {
        this.id = id;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.status = status;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getAppointmentDate() {
        return appointmentDate;
    }
    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
    public String getAppointmentTime() {
        return appointmentTime;
    }
    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }
    public int getPatientId() {
        return patientId;
    }
    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }
    public int getDoctorId() {
        return doctorId;
    }
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    public String getPatientName() {
        return patientName;
    }
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    public String getDoctorName() {
        return doctorName;
    }
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    @Override
    public String toString() {
        return "Appointment [id=" + id + ", appointmentDate=" + appointmentDate
                + ", appointmentTime=" + appointmentTime + ", patientId=" + patientId
                + ", doctorId=" + doctorId + ", patientName=" + patientName
                + ", doctorName=" + doctorName + ", status=" + status + "]";
    }
}