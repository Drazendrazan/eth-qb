Translations = {
    time = {
        weeks = "%{time} hace semanas",
        aweek = "hace una semana",
        days = "%{time} hace días",
        aday = "Hace un día",
        hours = "%{time} hours ago",
        ahour = "horas atras",
        mins = "%{time} hace minutos",
        amin = "Hace un minuto",
        secs = "Hace unos segundos",
    },
    logs = {
        invalid_account = "^6[^4Renewed-Banking^6] ^0 Cuenta no encontrada (%{account})",
        broke_account = "^6[^4Renewed-Banking^6] ^0 Cuenta(%{account}) está demasiado arruinado con el saldo de $%{amount}",
        illegal_action = "^6[^4Renewed-Banking^6] ^0 %{name} ha intentado realizar una acción en una cuenta que no creó.",
        no_account = "^6[^4Renewed-Banking^6] ^0 %{name} ha intentado realizar una acción en una cuenta que no creó.",
        existing_account = "^6[^4Renewed-Banking^6] ^0 Cuenta %{account} ya existe"
    },
    notify = {
        invalid_amount = "Cantidad Invalida para %{type}",
        not_enough_money = "La cuenta no tiene fondos suficientes!",
        comp_transaction = "%{name} tiene %{type} $%{amount}",
        fail_transfer = "Error al transferir a cuenta desconocida!",
        account_taken = "El ID de cuenta ya está en uso",
        unknown_player = "Jugador con ID '%{id}' no pudo ser encontrado.",
        loading_failed = "Error al cargar los datos bancarios!"
    },
    menu = {
        bank_name = "Banco De Los Santos",
        view_members = "Ver todos los miembros de la cuenta!",
        no_account = "Cuenta no encontrada",
        no_account_txt = "Necesitas ser el creador",
        manage_members = "Administrar miembros de la cuenta",
        manage_members_txt = "Ver miembros existentes y agregar",
        edit_acc_name = "Cambiar nombre de cuenta",
        edit_acc_name_txt = "Las transacciones no actualizarán los nombres antiguos",
        remove_member_txt = "Eliminar miembro de la cuenta!",
        add_member = "Agregar ciudadano a la cuenta",
        add_member_txt = "Ten cuidado a quien agregas(Requiere ID de ciudadano)",
        remove_member = "¿Estás seguro de que quieres eliminar Citizen?",
        remove_member_txt2 = "ID De el Ciudadano : %{id}; No hay vuelta atrás.",
        back = "Regresar",
        view_bank = "Ver cuenta bancaria",
        manage_bank = "Administrar cuenta bancaria",
        create_account = "Crear una nueva cuenta",
        create_account_txt = "Crear una nueva subcuenta bancaria!",
        manage_account = "Administrar cuentas existentes",
        manage_account_txt = "Ver cuentas existentes!",
        account_id = "ID de la cuenta (NO ESPACIOS)",
        change_account_name = "Cambiar nombre de cuenta",
        citizen_id = "ID De el Ciudadano/Estado",
        add_account_member = "Agregar miembro de la cuenta"
    },
    ui = {
        account_title = " Cuenta / ",
        account = " Cuenta ",
        amount = "Cantidad",
        comment = "Comentario",
        transfer = "Negocio or ID De el Ciudadano",
        cancel = "Cancelar",
        confirm = "Enviar",
        cash = "Dinero: $",
        transactions = "Transaciones",
        bank_name = "Banco De Los Santos",
        select_account = "Seleccione cualquier cuenta",
        message = "Mensaje",
        accounts = "Cuentas",
        balance = "Saldo disponible",
        frozen = "Estado de la cuenta: congelada",
        org = "Organización",
        personal = "Personal",
        personal_acc = "Cuenta Personal / ",
        deposit_but = "Depósito",
        withdraw_but = "Retirar",
        transfer_but = "Transferir",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})