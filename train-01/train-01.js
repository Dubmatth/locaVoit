$(document).ready(function (){

    const thead = $('thead')
    const tbody = $('tbody')
    const tfooter = $('tfooter')


    locEnCours = () => {


        $.ajax({
            url: '../rqTsLocEnCours.php',
            type: 'GET',
            dataType: 'json',
            async: false
        }).done(result => {
            let idRow = '';
            let dataRow;

            for (row of result){
                tbody.append(
                    $('<tr>', {
                        id: row.idLoc,
                        // style: "border: 1px solid red;cursor: pointer;"
                    }).append(
                        $('<button>', {
                            text: "Retour Location",
                        })
                    )
                )

                idRow = row.idLoc
                for(let i = 0; i < Object.keys(row).length; i++){
                    dataRow = Object.keys(row)[i]
                    $('#'+idRow).append(
                        $('<td>', {
                            text: row[dataRow]
                        })
                        )
                }                              
            }
        })
        
    }

    locEnCours();

    const infoTable = '<td class="infoTable" colspan="13"></td>'

    const dsIp = $('<input type="text" value="Salut" disabled>')


    $('tr').on('click', function(){
        const idLocFocus = $(this)[0].cells[0].innerHTML
        $(this).after('<tr style="height: 100px"><td></td>'+ infoTable +'</tr>');
        // console.log($(this).after().attr('hidden'))
        $('.infoTable').append(
            $(dsIp).val()
        )
    
           
       

    })

    
})