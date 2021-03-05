package services

import (
	"bytes"
	"crypto/rand"
	"fmt"
	"text/template"

	"net/smtp"

	log "github.com/sirupsen/logrus"
)

const (
	// smtp server configuration.
	smtpHost = "smtp.gmail.com"
	smtpPort = "587"
)

// EmailManager handels sending mails to the users.
type EmailManager struct {
	email string
	auth  smtp.Auth
}

//NewEmailManager creates a new EmailManager.
func NewEmailManager(
	Email,
	Password string) *EmailManager {

	// Authentication.
	auth := smtp.PlainAuth("", Email, Password, smtpHost)

	return &EmailManager{Email, auth}
}

func (manager *EmailManager) sendEmail(to []string, body bytes.Buffer) error {

	// Sending email.
	err := smtp.SendMail(smtpHost+":"+smtpPort, manager.auth, manager.email, to, body.Bytes())
	if err != nil {
		return err
	}

	log.Infof("Email Sent! to %s", to)
	return nil
}

// SendVerficationCode sends the given user an email with code.
func (manager *EmailManager) SendVerficationCode(user *User) error {

	t, _ := template.ParseFiles("mail_templates/template.html")

	var body bytes.Buffer

	mimeHeaders := "MIME-version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";\n\n"
	body.Write([]byte(fmt.Sprintf("Subject: This is a test subject \n%s\n\n", mimeHeaders)))

	code, err := manager.generateNewCode(6)

	if err != nil {
		return err
	}

	t.Execute(&body, struct {
		Name string
		CODE string
	}{
		Name: user.FirstName + user.LastName,
		CODE: code,
	})

	err = manager.sendEmail([]string{user.Email}, body)
	if err != nil {
		return err
	}
	return nil
}

const otpChars = "1234567890"

func (manager *EmailManager) generateNewCode(length int) (string, error) {
	buffer := make([]byte, length)
	_, err := rand.Read(buffer)
	if err != nil {
		return "", err
	}

	otpCharsLength := len(otpChars)
	for i := 0; i < length; i++ {
		buffer[i] = otpChars[int(buffer[i])%otpCharsLength]
	}

	return string(buffer), nil
}
