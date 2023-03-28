
  SELECT * FROM DBO.Nashville


-- Populate Property Address data

 SELECT * FROM dbo.Nashville
 WHERE PropertyAddress is null


  SELECT * FROM dbo.Nashville
 ORDER BY PropertyAddress

 --used  self join

	 SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
	FROM dbo.Nashville a
	JOIN .dbo.Nashville b
		ON a.ParcelID = b.ParcelID
		AND a.[UniqueID ] <> b.[UniqueID ]
	WHERE a.PropertyAddress is null

--update the data 


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.Nashville a
JOIN Nashville b
		ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

--CHECK THE DATA

SELECT * FROM dbo.Nashville
 ORDER BY PropertyAddress

 
-- Breaking out Address into Individual Columns (Address, City, State)

--LETS LOOK FOR THE ',' IN THE ADRESS
	SELECT SUBSTRING(PropertyAddress ,1, CHARINDEX(',',PropertyAddress) -1) AS Address
    , SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
	 FROM dbo.Nashville

-- create new column

ALTER TABLE Nashville
Add PropertySplitAddress Nvarchar(255);

Update Nashville
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE Nashville
Add PropertySplitCity Nvarchar(255);

Update Nashville
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

  SELECT * FROM DBO.Nashville
 
 
 --slipt the address
 Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From DBO.Nashville

--create new column

ALTER TABLE Nashville
Add OwnerSplitAddress Nvarchar(255);

Update Nashville
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Nashville
Add OwnerSplitCity Nvarchar(255);

Update Nashville
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Nashville
Add OwnerSplitState Nvarchar(255);

Update Nashville
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

  SELECT SoldAsVacant FROM DBO.Nashville

  --check how many 1 and 0

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From dbo.Nashville
Group by SoldAsVacant
order by 2



-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From dbo.Nashville

)
 

DELETE
From RowNumCTE
Where row_num > 1



--CHECKING 
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From dbo.Nashville

)
 

SELECT *
From RowNumCTE
Where row_num > 1




Select *
From dbo.Nashville.



--DONE