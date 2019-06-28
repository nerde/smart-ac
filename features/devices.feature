Feature: Devices

  Scenario: Creating a new device
    When I create the following device:
      | name             | Ar Conditioner |
      | serial_number    | 123456789      |
      | firmware_version | 1.1            |
    Then I should have the following devices:
      | name           | serial_number | firmware_version |
      | Ar Conditioner | 123456789     | 1.1              |

  Scenario: Notifying a device snapshot
    Given the following devices:
      | name           | serial_number | firmware_version | auth_token |
      | Ar Conditioner | 123456789     | 1.1              | 11223344   |
    When device "11223344" reports the following snapshot:
      | status              | ok               |
      | taken_at            | 2019-05-01 08:00 |
      | temperature_celsius | 24.59            |
      | humidity_percentage | 54.99            |
      | carbon_monoxide_ppm | 6.847            |
    Then I should have the following device snapshots:
      | device    | status | taken_at                | temperature_celsius | humidity_percentage | carbon_monoxide_ppm |
      | 123456789 | ok     | 2019-05-01 08:00:00 UTC | 24.59               | 54.99               | 6.847               |
