function updateHiddenDate(elt)
{
    elt = $(elt);
    if (elt.value.length >= 10) {
        day = elt.value.substring(0,2);
        month = elt.value.substring(3,5);
        year = elt.value.substring(6,10);
        elt.up().down("input.date-selector-hidden").value = year + "-" + month + "-" + day;
    }

    if (elt.value.length == 0) {
        elt.up().down("input.date-selector-hidden").value = "";
    }
}

function updateHiddenDateTime(elt)
{
    elt = $(elt);
    if (elt.value.length >= 16) {
        day = elt.value.substring(0,2);
        month = elt.value.substring(3,5);
        year = elt.value.substring(6,10);
        hour = elt.value.substring(11,13);
        minute = elt.value.substring(14,16);
        elt.up().down("input.datetime-selector-hidden").value = year + "-" + month + "-" + day + " " + hour + ":" + minute;
    }

    if (elt.value.length == 0) {
        elt.up().down("input.datetime-selector-hidden").value = "";
    }
}

function onDateCalendarUpdate(calendar, date) {
    $(calendar.params.displayArea).value = calendar.date.print("%d/%m/%Y");
    $(calendar.params.inputField).value = calendar.date.print("%Y-%m-%d %H:%M:%S");
    if ($(calendar).dateClicked)
    {
        $(calendar).destroy();
    }
}

function onDatetimeCalendarUpdate(calendar, date) {
    $(calendar.params.displayArea).value = calendar.date.print("%d/%m/%Y %H:%M");
    $(calendar.params.inputField).value = calendar.date.print("%Y-%m-%d %H:%M:%S");
//    if ($(calendar).dateClicked)
//    {
//        $(calendar).destroy();
//    }
}

function onDateFieldBlur(elt)
{
    if (!isValidDateString($(elt).value) && $(elt).value != "")
    {
        alert("La date entrée n'est pas valide.\n Exemple : 09/01/2009")
        $(elt).value = "";
        elt.up().down("input.date-selector-hidden").value = "";
    }
}

function onDateTimeFieldBlur(elt)
{
    if (!isValidDateTimeString($(elt).value) && $(elt).value != "")
    {
        alert("La date entrée n'est pas valide.\n Exemple : 09/01/2009 13:45")
        $(elt).value = "";
        elt.up().down("input.datetime-selector-hidden").value = "";
    }
}

function isValidDateString(str)
{
    return(/^\d{2}\/\d{2}\/\d{4}$/.test(str))
}

function isValidDateTimeString(str)
{
    return(/^\d{2}\/\d{2}\/\d{4}\s\d{2}:\d{2}$/.test(str))
}

function setupCalendarFor(inputFieldId, displayFieldId, showTime)
{
    if (showTime)
    {
        Calendar.setup({
            inputField : inputFieldId,
            align : "bR",
            ifFormat : "%Y-%m-%d %H:%M",
            displayArea : displayFieldId,
            daFormat : "%d/%m/%Y %H:%M",
            showsTime : true,
            showOthers : true,
            onSelect : onDatetimeCalendarUpdate,
            button: displayFieldId + "_img"
        });
    }
    else
    {
        Calendar.setup({
            inputField : inputFieldId,
            align : "bR",
            ifFormat : "%Y-%m-%d %H:%M",
            displayArea : displayFieldId,
            daFormat : "%d/%m/%Y",
            showsTime : false,
            showOthers : true,
            onSelect : onDateCalendarUpdate,
            button: displayFieldId + "_img"
        });
    }
}
