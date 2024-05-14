function deleteCompte(rib) {
    swal({
        title: "Are you sure?",
        text: "Once deleted, you will not be able to recover this account!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
    .then((willDelete) => {
        if (willDelete) {
            $.ajax({
                url : "CompteControler",
                type : "POST",
                data : {
                    action : "Delete",
                    rib : rib
                },
                success : function() {
                    $("#tr" + rib).remove();
                    swal("Your Compte has been deleted!", {
                        icon: "success",
                    });
                },
                error : function() {
                    swal("Poof! server error!", {
                        icon: "error",
                    });
                }
            });
        } else {
            swal("Your account is safe!", {
                icon: "info",
            });
        }
    });
}
