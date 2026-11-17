package entity;

public class Bill {
    private int id;
    private int patientId;
    private String patientName;
    private double amount;
    private String status;
    public Bill() {
    }
    public Bill(int patientId, double amount, String status) {
        this.patientId = patientId;
        this.amount = amount;
        this.status = status;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getBillCode() {
        return "BILL-" + id;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @Override
    public String toString() {
        return "Bill [id=" + id + ", patientId=" + patientId + ", patientName=" + patientName
                + ", amount=" + amount + ", status=" + status + "]";
    }
}