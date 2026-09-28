CLASS zcl_fill_emp_6444 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fill_emp_6444 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lt_employees TYPE TABLE OF zemployee_hub.

    " Clear existing data to prevent duplicates if run multiple times
    DELETE FROM zemployee_hub.

    " Prepare 3 test records (2 Active, 1 Inactive)
    lt_employees = VALUE #(
      ( employee_id  = 'EMP001'
        first_name   = 'John'
        last_name    = 'Doe'
        email        = 'john.doe@company.com'
        department   = 'IT'
        designation  = 'Software Engineer'
        joining_date = '20250115'
        status       = 'ACTIVE' )

      ( employee_id  = 'EMP002'
        first_name   = 'Jane'
        last_name    = 'Smith'
        email        = 'jane.smith@company.com'
        department   = 'HR'
        designation  = 'HR Manager'
        joining_date = '20240510'
        status       = 'ACTIVE' )

      ( employee_id  = 'EMP003'
        first_name   = 'Michael'
        last_name    = 'Scott'
        email        = 'michael.s@company.com'
        department   = 'Sales'
        designation  = 'Regional Manager'
        joining_date = '20230301'
        status       = 'INACTIVE' )
    ).

    " Insert the data into the database table
    INSERT zemployee_hub FROM TABLE @lt_employees.

    IF sy-subrc = 0.
      out->write( 'Test data inserted successfully!' ).
    ELSE.
      out->write( 'Failed to insert test data.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
