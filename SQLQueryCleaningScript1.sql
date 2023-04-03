Select *
From ProjectPortfolio..NashvilleHousing

-- Standardize Date Format - Saledate format from Datetime to Date 

Select SaleDate, CONVERT(Date, SaleDate)
From ProjectPortfolio..NashvilleHousing

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

Select SaleDate, CONVERT(Date, SaleDate), SaleDateConverted
From ProjectPortfolio..NashvilleHousing

-------------------------------------------------------------------------------------------------------------

-- Populate Property Address Data for rows where PropertyAddress=Null, if same ParcelID exists with a PropertyAddress
-- Where with same ParcelID, then PropertyAddress should be the same

Select *
From ProjectPortfolio..NashvilleHousing
--Where PropertyAddress is null
Order by ParcelID


--Join rows with same ParcelID but different UniqueID, then we populate the other empty one
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From ProjectPortfolio..NashvilleHousing a
JOIN ProjectPortfolio..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From ProjectPortfolio..NashvilleHousing a
JOIN ProjectPortfolio..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

---------------------------------------------------------------------------------------------------------
-- Breaking PropertyAddress into (address, city)

Select PropertyAddress
FROM ProjectPortfolio..NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as City
FROM ProjectPortfolio..NashvilleHousing

-- create a newcolumn to insert the splitted new columns to the table
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255)

Update NashvilleHousing
SET  PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(255)

Update NashvilleHousing
SET  PropertySplitCity= SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) 


-- Alternative way, Splitting OwnerAddress to (address, city, state)
Select OwnerAddress
FROM ProjectPortfolio..NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress,',','.') , 3) as Address,
PARSENAME(REPLACE(OwnerAddress,',','.') , 2) as City,
PARSENAME(REPLACE(OwnerAddress,',','.') , 1) as State
FROM ProjectPortfolio..NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255)

Update NashvilleHousing
SET  OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.') , 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(255)

Update NashvilleHousing
SET  OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.') , 2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(255)

Update NashvilleHousing
SET  OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.') , 1)

-----------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant' field

Select Distinct(SoldAsVacant)
FROM NashvilleHousing

Select SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' Then 'No'
		ELSE SoldAsVacant 
	END
FROM NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' Then 'No'
		ELSE SoldAsVacant 
	END
FROM NashvilleHousing

-----------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
SELECT * ,
	ROW_NUMBER() OVER (
	Partition by ParcelID, 
				PropertyAddress, 
				SalePrice, 
				SaleDate, 
				LegalReference
				ORDER BY 
					UniqueID
					) as row_num
FROM ProjectPortfolio.dbo.NashvilleHousing)

DELETE
FROM RowNumCTE
Where row_num > 1 

-----------------------------------------------------------------------------------------------------------

-- DELETE Unused Columns

SELECT *
FROM ProjectPortfolio.dbo.NashvilleHousing

ALTER TABLE ProjectPortfolio.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate