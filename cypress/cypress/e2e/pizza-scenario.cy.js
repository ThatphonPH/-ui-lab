const fields = {
  calories: () => cy.contains('label', /^Max Calories per Slice$/).siblings('input'),
  tools: 'select',
  vegetarian: '#default-checkbox',
  name: 'input#pizza-name',
}


describe('QP-01 A custom pizza reaches the admin list', () => {
  // Check the pizza restrictions, the anonymous rating prompt, and the admin list.
  it('follows the steps of QP-01', () => {
    // Step 1: open QuickPizza as a guest
    cy.visit('https://quickpizza.grafana.com')
    cy.get('h1').should('have.text', 'Looking to break out of your pizza routine?')

    // Step 2: reveal the advanced fields
    cy.contains('label', 'Advanced').click()
    fields.calories().should('be.visible')
    cy.get(fields.tools).should('be.visible').contains('option', /^Knife$/)
    cy.get(fields.vegetarian).should('be.visible')
    cy.get(fields.name).should('be.visible')
  })
})
