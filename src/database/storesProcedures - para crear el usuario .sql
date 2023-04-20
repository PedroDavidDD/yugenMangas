
-- -----------------------------
-- images
-- -----------------------------
	CREATE PROCEDURE insert_images(
		@img_title_id int,
		@img_name varchar(100),
		@img_image varchar(100),
		@img_tp_id int
	) AS 
	BEGIN 
		BEGIN TRANSACTION;
		SAVE TRANSACTION puntoDeSalvado;
		
		BEGIN TRY

			INSERT INTO dbo.images 
			VALUES (@img_title_id, @img_name, @img_image, @img_tp_id);

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION puntoDeSalvado;
			END
		END CATCH
	END;


-- -----------------------------
-- mangas_view 
-- -----------------------------
CREATE VIEW mangas_view AS  
    SELECT 
	m.man_description,
	m.man_date,
	ar.ar_type,
	authors.author_nombre,
	com.com_description,
	prod.prod_team,
	scans.scan_name,
	titles.title_en,
        (SELECT SUM(views.view_count) FROM views 
        JOIN mangas ON mangas.man_title_id = views.view_title_id 
        WHERE views.view_title_id = m.man_title_id) AS "Número de vistas totales"
    FROM mangas AS m
    JOIN agerestriction AS ar 
    ON m.man_ar_id = ar.ar_id
    JOIN authors AS authors
    ON m.man_author_id = authors.author_id 
    JOIN titles AS titles
    ON m.man_title_id = titles.title_id
    JOIN comments AS com
    ON m.man_comment_id = com.com_id
    JOIN productions AS prod
    ON m.man_production_id = prod.prod_id
    JOIN scans AS scans
    ON m.man_scan_id = scans.scan_id;  

-- Query the view  
SELECT * FROM mangas_view;

CREATE PROCEDURE insert_mangas(
		@man_description varchar(100), 
        
		@man_ar_id int(10), 
		@man_author_id int(10), 
		@man_comment_id int(10), 
		@man_production_id int(10), 
		@man_scan_id int(10), 
		@man_title_id int(10), 
	)  AS 
	BEGIN 
		BEGIN TRANSACTION;
		SAVE TRANSACTION puntoDeSalvado;
		
		BEGIN TRY
			
			DECLARE @man_date date;
			SET @man_date = (SELECT DATE_FORMAT(NOW(), "%Y-%m-%d"));
            
			DECLARE @msg varchar(100);
			SET @msg = '';

				IF ((SELECT count(users.user_email) FROM users WHERE users.user_email = @user_email) <= 1) 
				BEGIN  
					IF (@user_img_title_id > 0 OR @user_ucla_id > 0 OR @user_ur_id > 0) 
					BEGIN
						INSERT INTO users
						VALUES (
							@user_name, 
							@user_email, 
							@user_password, 
							@user_created_at, 
							@user_state, 
							@user_last_login, 
							@user_country, 
							@user_phone, 
							@user_date_of_birth, 
							@user_gender, 
							@user_address, 
							@user_security_code, 
							@user_img_title_id, 
							@user_ucla_id, 
							@user_ur_id);
					END	
				END	
				IF ((SELECT count(users.user_email) FROM users WHERE users.user_email = @user_email) > 1) 
				BEGIN  
					SELECT TOP(1) msg= 'Ya existe un usuario con el mismo correo electronico',
						users.user_email as 'Correo Duplicado' FROM users
						WHERE users.user_email= 'david@example.com'
						ORDER BY users.user_id ASC;
				END	

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
                    IF @@TRANCOUNT > 0
                    BEGIN
                        ROLLBACK TRANSACTION puntoDeSalvado;
                    END
		END CATCH
	END;
	
	EXEC insert_users 'DAVID', 'david-david@example.com', 'mysecretpassword', '2022-03-08 16:45:00','2022-03-13 11:45:00',
	'Chile', '512123678', '1998-03-25', 'M', 'Calle Falsa 456', '2468', -2, 1, -2;
	



-- -----------------------------
-- agerestriction
-- -----------------------------


insert into agerestriction (ar_type) values (@mayor),(@menor);