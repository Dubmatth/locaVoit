$(document).ready(function (){

    const tbody = $('tbody')

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
    const inputDuree = $('<label>Durée</label><input type="text" disabled>')
    const inputDate = $('<label>Date de fin</label><input type="date" required>')
    const inputCalcDate = $('<label>Jours</label><input type="text" disabled><br>')
    const inputKm = $('<label>Kms</label><input type="text" disabled>')
    const inputKmFin = $('<label>Kms parcouru</label><input type="text" required>')
    const inputCalcKm = $('<label>Kms actuel</label><input type="text" disabled><br>')
    const inputPrix = $('<label>Prix : </label><input type="text" disabled><label> €</label><br>')
    const inputRemise = $('<label>Remise : </label><input type="text"><br>')
    const btnPayer = $('<button type="submit">Payer</button>')
    const btnAnnuler = $('<button type="submit">Annuler</button>')

    const toutLesTr = $('tr')

    toutLesTr.on('click', function(){

        const idLocFocus = $(this)[0].cells[0].innerHTML
        $(this).after('<tr class="removeTable" style="height: 100px"><td></td>'+ infoTable +'</tr>');      
        trFocus = $('tr').filter('#' + idLocFocus)

        // trVisible = $('.removeTable')
        // trVisible.on('click', function(){
        //     trVisible.remove()
        // })

    
        // Ajout des éléments dans la ligne INFO //
        $('.infoTable').append(
            $(inputDuree).val(trFocus[0].children[2].innerHTML),
            // FIXME Probleme avec le input dans la date si on modifie au click fléché
            $(inputDate).attr('min', '2018-11-24'),
            $(inputCalcDate),
            $(inputKm).val(trFocus[0].children[4].innerHTML),
            $(inputKmFin),
            $(inputCalcKm),
            $(inputPrix),
            $(inputRemise),
            $(btnPayer),
            $(btnAnnuler)
        )

        // CALCUL DES Jours de location //
        $(inputDate).on('change', () => {
            let date1 = new Date(inputDuree.val())
            let date2 = new Date(inputDate[1].value)

            let resultDate;
            diffdate = (d1,d2) => {
                var WNbJours = d2.getTime() - d1.getTime();
                return Math.ceil(WNbJours/(1000*60*60*24));
            }
            resultDate = diffdate(date1,date2)
            $(inputCalcDate).val(resultDate)
        })


        // CALCUL DES KMS PARCOURU ET TARIFICATION //
        calculPrix = (event) => {
            // Calcul des kms
            const kmDebut = $(inputKm).val()
            const kmFin = $(inputKmFin).val(event.target.value)
            const kmParcouru = parseInt(kmDebut) + parseInt(kmFin.val())
            $(inputCalcKm.val(kmParcouru))

            // Prix pour les kms parcourus
            const prixKm = $(this)[0].cells[11].innerHTML
            const prixAPayerKm = parseInt(kmFin.val()) * parseFloat(prixKm)

            // Prix pour les jours d'utilisation
            const nbJours = $(inputCalcDate).val()
            const prixParJour = $(this)[0].cells[12].innerHTML
            const prixAPayerJourUtiliser = nbJours * prixParJour

            const prixDefinitif = parseFloat(prixAPayerKm) + parseFloat(prixAPayerJourUtiliser)
                
            $(inputPrix).val(prixDefinitif)  

        }
        $(inputKmFin).on('input', calculPrix)

        // On va calculer la remise
        calculRemise = () => {
            const remise = inputRemise[1].value
            if (inputRemise[1].value !== ""){
                $(inputPrix).val(($(inputPrix).val() - remise)) 
            } else {
                $(inputPrix).val()
            }
        }
        $(inputRemise).on('change', calculRemise)
            
        
        payChecked = () => {

            const idLoc = $(this)[0].id
            const dFinLoc = inputDate[1].value
            const kmFinLoc = inputCalcKm.val()
            const prixLoc = inputPrix.val()
            const remLoc = "Aucunes remarques"

            const location = { 
                        dFinLoc: dFinLoc,
                        kmFinLoc: kmFinLoc, 
                        prixLoc: prixLoc,
                        remLoc: remLoc ,
                        idLoc: idLoc
                    };

            $.ajax({
                url: '../rqRetourUneLoc.php',
                type: 'POST',
                dataType: 'json',
                data: {
                    location: JSON.stringify(location)
                
                },
                async: true
            }).done(function(){
                console.log('good')
            })

        }

        btnPayer.on('click', payChecked)



        // ----- CSS ----- //
        $('input').css('margin', '1em')
    })


    


    
})