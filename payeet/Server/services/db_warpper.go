package services

import (
	"errors"
	"sync"
)

// UserStore is an interface handels storing users.
type UserStore interface {

	// save a new user to the storge.
	AddUser(user *User) error

	FindWithMail(uuid string) (*User, error)
	FindWithUUID(uuid string) (*User, error)
}

// InMemoryUserStore stores users in memory.
type InMemoryUserStore struct {
	mutex sync.Mutex
	users map[string]*User
}

// NewMemoryUserStore makes a new InMemoryUserStore
func NewMemoryUserStore() *InMemoryUserStore {
	return &InMemoryUserStore{
		users: make(map[string]*User),
	}
}

// AddUser save a new user to the storge.
func (store *InMemoryUserStore) AddUser(user *User) error {
	store.mutex.Lock()
	defer store.mutex.Unlock()

	if store.users[user.uuid] != nil {
		return errors.New("ErrAlreadyExists")
	}

	store.users[user.uuid] = user.Clone()

	return nil

}

//FindWithUUID finds a user in storge.
func (store *InMemoryUserStore) FindWithUUID(uuid string) (*User, error) {
	store.mutex.Lock()
	defer store.mutex.Unlock()

	d := store.users[uuid]

	if d == nil {
		return nil, nil
	}

	return d.Clone(), nil

}

//FindWithMail finds a user in storge.
func (store *InMemoryUserStore) FindWithMail(mail string) (*User, error) {
	store.mutex.Lock()
	defer store.mutex.Unlock()

	for _, usr := range store.users {
		if usr.email == mail {
			return usr.Clone(), nil
		}
	}

	return nil, nil

}
