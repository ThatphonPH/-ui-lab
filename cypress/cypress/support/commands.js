// Wait for the admin form to become interactive before submitting demo credentials.
Cypress.Commands.add('adminLogin', (user, password) => {
  cy.visit('https://quickpizza.grafana.com/admin')
  cy.get('#svelte-announcer').should('exist')
  cy.get('#username').clear().type(user)
  cy.get('#password').clear().type(password, { log: false })
  cy.get('button[type="submit"]').click()
})
