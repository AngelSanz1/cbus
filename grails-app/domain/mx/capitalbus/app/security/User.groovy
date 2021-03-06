package mx.capitalbus.app.security

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString


@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class User {

    private static final long serialVersionUID = 1

    transient springSecurityService

    String username
    String password
    boolean enabled = true
    String email
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    User(String username, String password) {
        this()
        this.username = username
        this.password = password
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this)*.role
    }


    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {

        if (isDirty('password')) {
            encodePassword()
        }

    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ?
                springSecurityService.encodePassword(password) :
                password
    }

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        email unique: true, email: true
        password blank: false
    }

    static mapping = {

        tablePerHierarchy false
        id generator: 'identity'
        table '`user`'
        password column: '`password`'
        email unique: true
    }
}
