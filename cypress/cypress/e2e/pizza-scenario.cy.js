const fields = {
  calories: () => cy.contains('label', /^Max Calories per Slice$/).siblings('input'),
  tools: 'select',
  vegetarian: '#default-checkbox',
  name: 'input#pizza-name',
}

function stamp() {
  const date = new Date()
  const two = (number) => String(number).padStart(2, '0')
  const day = [date.getFullYear(), two(date.getMonth() + 1), two(date.getDate())].join('')
  const time = [date.getHours(), date.getMinutes(), date.getSeconds()].map(two).join('')
  return day + '-' + time
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

    // Step 3: fill in and verify the restrictions and name
    const pizzaName = 'Lab Pizza ' + stamp()
    fields.calories().clear().type('600').should('have.value', '600')
    cy.get(fields.tools).select('Knife')
    cy.contains('option', /^Knife$/).should('be.selected')
    cy.get(fields.vegetarian).check().should('be.checked')
    cy.get(fields.name).type(pizzaName).should('have.value', pizzaName)

    // Step 4: verify the recommendation
    cy.get('button[name="pizza-please"]').click()
    cy.get('#recommendations').should('contain', 'Name: ' + pizzaName)
    cy.contains('#recommendations p', 'Tool:').should('not.contain', 'Knife')
    cy.contains('#recommendations p', 'Calories per slice:').invoke('text').then((text) => {
      const calories = Number(text.replace('Calories per slice:', ''))
      expect(calories).to.be.at.most(600)
    })

    // Step 5: verify the guest rating prompt
    cy.get('button[name="rate-5"]').click()
    cy.get('#rate-result').should('have.text', 'Please log in first.')
  })
})
