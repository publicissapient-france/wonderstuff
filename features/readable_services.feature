Feature: Potential customer can read about services

  In order to generate more leads for my business
  As a business owner
  I want web users to be able to read about my services

  Background:

    Given I have provisioned the following infrastructure:
    | Server Name | Operating System | Version | Chef Version | Run List       |
    | wonderstuff | ubuntu           |   12.04 |       11.4.4 | wonderstuff::default |
    And I have run Chef

  Scenario: User visits home page
    Given a url "http://wonderstuff-design.me"
    When a web user browses to the URL
    Then the user should see "Wonderstuff Design is a boutique graphics design agency."