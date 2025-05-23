# **Disk Space Monitor with Email Alerts**  

🚀 **A Bash script to monitor disk space and send email alerts when usage exceeds a threshold.**  

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)  
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)  
![Postfix](https://img.shields.io/badge/Postfix-%23007ACC?style=for-the-badge&logo=mail.ru&logoColor=white)  

---

## **📌 Overview**  
This project automates disk space monitoring on Linux systems. It:  
✅ Checks disk usage at regular intervals (via Cron).  
✅ Sends email alerts (using Postfix + Gmail SMTP) when usage crosses a threshold.  
✅ Helps prevent system failures due to low disk space.  
  
---

## **🛠️ Prerequisites**  
- Linux system (tested on Ubuntu/Debian)  
- `postfix` and `mailutils` installed  
- A Gmail account (for sending alerts)  

---

## **⚡ Installation & Setup**  

### **1. Install Required Packages**  
```bash
sudo apt update
sudo apt install postfix mailutils -y
```
*(Select "Internet Site" during Postfix installation)*  

### **2. Configure Postfix for Gmail SMTP**  
Edit `/etc/postfix/main.cf`:  
```bash
sudo nano /etc/postfix/main.cf
```  
Add these lines:  
```plaintext
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_security_level = encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```  

### **3. Set Up Gmail Credentials**  
Create `/etc/postfix/sasl_passwd`:  
```bash
sudo nano /etc/postfix/sasl_passwd
```  
Add (replace with your Gmail and [App Password](https://myaccount.google.com/apppasswords)):  
```plaintext
[smtp.gmail.com]:587 your@gmail.com:your-app-password
```  

Secure the file:  
```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo systemctl restart postfix
```  

### **4. Test Email Sending**  
```bash
echo "Test email" | mail -s "Test" your@gmail.com
```  

---

## **📜 Using the Script**  

### **1. Download the Script**  
```bash
wget https://raw.githubusercontent.com/yourusername/repo/main/fs_status.sh
chmod +x fs_status.sh
```  

### **2. Configure the Script**  
Edit the script to:  
- Change the monitored partition (`sda6` by default)  
- Adjust the threshold (`6%` by default)  
- Set your email address  

### **3. Run Manually**  
```bash
./fs_status.sh
```  

### **4. Schedule with Cron (For Automatic Checks)**  
```bash
crontab -e
```  
Add (runs hourly):  
```plaintext
0 * * * * /path/to/fs_status.sh >> /var/log/fs_status.log 2>&1
```  

---

## **📂 Files**  
- `fs_status.sh` - Main monitoring script  
- `/etc/postfix/` - Postfix configuration files  

---

## **🚨 Troubleshooting**  
- **Emails not sending?** Check:  
  ```bash
  tail -f /var/log/mail.log
  ```  
- **Gmail blocking emails?** Enable "Less secure apps" or use an App Password.  

---

## **📜 License**  
MIT  

---

## **📬 Contact**  
Questions? Open an issue or reach out!  

**GitHub:** [YourProfile](https://github.com/iam-sdeep)  
  

--- 

⭐ **Star this repo if you found it useful!** ⭐  
