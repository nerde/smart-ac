Feature: Devices

  Scenario: Creating a new device
    When I create the following device:
      | name             | Ar Conditioner |
      | serial_number    | 123456789      |
      | firmware_version | 1.1            |
    Then I should receive a "201" response
    And I should have the following devices:
      | name           | serial_number | firmware_version |
      | Ar Conditioner | 123456789     | 1.1              |

  Scenario: Creating device snapshots for monitoring
    Given the following devices:
      | name           | serial_number | firmware_version | auth_token |
      | Ar Conditioner | 123456789     | 1.1              | 11223344   |
    When device "11223344" reports the following snapshots:
      | status | taken_at         | temperature_celsius | humidity_percentage | carbon_monoxide_ppm |
      | ok     | 2019-05-01 08:00 | 24.59               | 54.99               | 6.847               |
    Then I should receive a "201" response
    And I should have the following device snapshots:
      | device    | status | taken_at                | temperature_celsius | humidity_percentage | carbon_monoxide_ppm |
      | 123456789 | ok     | 2019-05-01 08:00:00 UTC | 24.59               | 54.99               | 6.847               |

  Scenario: Creating device snapshots with invalid data
    Given the following devices:
      | name           | serial_number | firmware_version | auth_token |
      | Ar Conditioner | 123456789     | 1.1              | 11223344   |
    When device "11223344" reports the following snapshots:
      | status | taken_at         | temperature_celsius | humidity_percentage | carbon_monoxide_ppm |
      | ok     | 2019-05-01 08:00 | 24.59               | 54.99               | 6.847               |
      | ok     | 2019-05-01 08:01 |                     | 54.99               | 6.847               |
    Then I should receive a "422" response
    And I should have no device snapshots
