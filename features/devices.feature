Feature: Devices

  Scenario: Creating a new device
    When I create the following device:
      | name             | Ar Conditioner |
      | serial_number    | 123456789      |
      | firmware_version | 1.1            |
    Then I should have the following devices:
      | name           | serial_number | firmware_version |
      | Ar Conditioner | 123456789     | 1.1              |
