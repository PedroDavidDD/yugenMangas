
-- -----------------------------
-- insert_images
-- -----------------------------
	CREATE PROCEDURE insert_images(
		@img_name varchar(100),
		@img_image varchar(100)
	) AS 
	BEGIN 
		BEGIN TRANSACTION;
		SAVE TRANSACTION puntoDeSalvado;
		
		BEGIN TRY

			INSERT INTO dbo.images 
			VALUES (@img_name, @img_image);

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
        COALESCE((SELECT SUM(views.view_count) FROM views 
        JOIN mangas ON mangas.man_title_id = views.view_title_id 
        WHERE views.view_title_id = m.man_title_id), 0) AS "Número de vistas totales"
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

-- -----------------------------
-- insert_mangas 
-- -----------------------------

CREATE PROCEDURE insert_mangas(
    @man_description varchar(100), 
    @man_ar_id int, 
    @man_author_id int, 
    @man_comment_id int, 
    @man_production_id int, 
    @man_scan_id int, 
    @man_title_id int
) AS 
BEGIN 
    BEGIN TRANSACTION;
    SAVE TRANSACTION puntoDeSalvado;
    
    BEGIN TRY
        
        DECLARE @man_date date;
        SET @man_date = GETDATE();
        
        DECLARE @msg varchar(100);
        SET @msg = '';
        
        -- el titulo, si existe en titles
        IF ( (SELECT count(titles.title_id) FROM titles WHERE titles.title_id = @man_title_id) >= 1) 
		BEGIN  
		
			-- Si existe el título del manga
			IF ((SELECT count(mangas.man_title_id) FROM mangas WHERE mangas.man_title_id = @man_title_id) >= 1) 
			BEGIN  
				SELECT top(1) msg= 'Ya existe el nombre de este manga.',
					titles.title_en as 'Manga duplicado' 
				FROM mangas 
				JOIN titles ON titles.title_id = mangas.man_title_id
				WHERE mangas.man_title_id = @man_title_id;
			END	
			-- Si los datos enviados están llenos y si no existe el título del manga
			IF ((SELECT count(mangas.man_title_id) FROM mangas WHERE mangas.man_title_id = @man_title_id) < 1) 
			BEGIN  
				IF ((@man_ar_id) > 0 AND (@man_author_id) > 0 AND (@man_production_id) > 0 AND (@man_scan_id) > 0 AND (@man_title_id) > 0 ) 
				BEGIN  
					INSERT INTO mangas VALUES(@man_description, @man_date, @man_ar_id, @man_author_id, @man_comment_id, @man_production_id, @man_scan_id, @man_title_id);
					
					SELECT top(1) titles.title_en as 'Manga Agregado' 
					FROM mangas 
					JOIN titles ON titles.title_id = mangas.man_title_id
					WHERE mangas.man_title_id = @man_title_id;

				END	
			END	
			
        END	
		-- el titulo, no existe en titles
        IF ( (SELECT count(titles.title_id) FROM titles WHERE titles.title_id = @man_title_id) < 1) 
		BEGIN  
			SELECT top(1) msg= 'No existe el ID del título en la tabla TITLES'
			FROM titles;
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


EXECUTE insert_mangas 
    @man_description = 'Descripción del manga 9', 
    @man_ar_id = 1, 
    @man_author_id = 2, 
    @man_comment_id = 3, 
    @man_production_id = 4, 
    @man_scan_id = 5, 
    @man_title_id = 9;
