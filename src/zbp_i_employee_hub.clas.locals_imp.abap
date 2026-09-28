CLASS lhc_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

    METHODS validateEmployeeID FOR VALIDATE ON SAVE
      IMPORTING keys FOR Employee~validateEmployeeID.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Employee~validateStatus.

ENDCLASS.

CLASS lhc_Employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateEmployeeID.
    " Read the keys submitted by the user
    READ ENTITIES OF zi_employee_hub IN LOCAL MODE
      ENTITY Employee
        FIELDS ( EmployeeID ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employees).

    LOOP AT lt_employees INTO DATA(ls_employee).
      " Check for duplicate Employee ID in database
      SELECT SINGLE FROM zemployee_hub
        FIELDS employee_id
        WHERE employee_id = @ls_employee-EmployeeID
        INTO @DATA(lv_existing_id).

      IF sy-subrc = 0.
        " Report failure
        APPEND VALUE #( %tky = ls_employee-%tky ) TO failed-employee.

        " Report message
        APPEND VALUE #( %tky        = ls_employee-%tky
                        %state_area  = 'VALIDATE_EMPLOYEE_ID'
                        %msg         = new_message_with_text(
                                         severity = if_abap_behv_message=>severity-error
                                         text     = 'Employee already exists.' )
                        %element-EmployeeID = if_abap_behv=>mk-on
                      ) TO reported-employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateStatus.
    " Read status submitted by user
    READ ENTITIES OF zi_employee_hub IN LOCAL MODE
      ENTITY Employee
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employees).

    LOOP AT lt_employees INTO DATA(ls_employee).
      IF ls_employee-Status IS NOT INITIAL
         AND ls_employee-Status <> 'ACTIVE'
         AND ls_employee-Status <> 'INACTIVE'.

        " Report failure
        APPEND VALUE #( %tky = ls_employee-%tky ) TO failed-employee.

        " Report message
        APPEND VALUE #( %tky        = ls_employee-%tky
                        %state_area  = 'VALIDATE_STATUS'
                        %msg         = new_message_with_text(
                                         severity = if_abap_behv_message=>severity-error
                                         text     = 'Invalid employee status.' )
                        %element-Status = if_abap_behv=>mk-on
                      ) TO reported-employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
