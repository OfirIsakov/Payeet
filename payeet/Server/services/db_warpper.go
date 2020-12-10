package services

import (
	"sync"
)

// UserStore is an interface handels storing users.
type UserStore interface {

	// save a new user to the storge.
	AddUser(user *User) error

	// find a user in storge.
	Find(uuid string) (*User, error)
}

// InMemoryUserStore stores users in memory.
type InMemoryUserStore struct {
	mutex sync.Mutex
	users map[string]*User
}

// this function makes a new InMemoryUserStore
func NewMemoryUserStore() *InMemoryUserStore {
	return &InMemoryUserStore{
		users: make(map[string]*User),
	}
}

// save a new user to the storge.
func (store *InMemoryUserStore) AddUser(user *User) error {
	store.mutex.Lock()
	defer store.mutex.Unlock()

	if store.User[user.uuid] != nil {
		return ErrAlreadyExists
	}

	store.User[user.uuid] = user.Clone()

	return nil

}

// find a user in storge.
func (store *InMemoryUserStore) Find(uuid string) (*User, error) {
	store.mutex.Lock()
	defer store.mutex.Unlock()

	d := store.users[user.uuid]

	if d == nil {
		return nil, nil
	}

	return user.Clone(), nil

}
