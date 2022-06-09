/* eslint-disable no-undef */
describe('Product Details', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Loads the home page", () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Should increase the cart count by 1 when user clicks add to cart", () => {
    cy.get('a[href="/cart"]').should('contain', 'My Cart (0)');
    cy.get('.button_to').first().submit();
    cy.get('a[href="/cart"]').should('contain', 'My Cart (1)');
  });
});

