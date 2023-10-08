select *
from NashvilleHousing


--Standardize Date Format

select SaleDateConverted, convert(date,SaleDate)
from NashvilleHousing
Update NashvilleHousing
set SaleDate = convert(date,SaleDate)

alter table NashvilleHousing
add SaleDateConverted date;
Update NashvilleHousing
set SaleDateConverted = convert(date,SaleDate)

--Populate Property Address data

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing as a
join NashvilleHousing as b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null
Update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing as a
join NashvilleHousing as b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--Breaking out Address into Individual Columns (address, City, State)

--SELECT 
--     REVERSE(PARSENAME(REPLACE(REVERSE(PropertyAddress), ',', '.'), 1)) AS street
--   , REVERSE(PARSENAME(REPLACE(REVERSE(PropertyAddress), ',', '.'), 2)) AS city
--   , REVERSE(PARSENAME(REPLACE(REVERSE(PropertyAddress), ',', '.'), 3)) AS state
--FROM NashvilleHousing;
--GO

select 
substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) as Address,
SUBSTRING(propertyaddress, CHARINDEX (',',propertyaddress)+1, len(PropertyAddress)) as address
from NashvilleHousing

alter table NashvilleHousing
add PropertySplitAddress nvarchar(255);
Update NashvilleHousing
set PropertySplitAddress = substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1)

alter table NashvilleHousing
add PropertySplitCity nvarchar(255);
Update NashvilleHousing
set PropertySplitCity = SUBSTRING(propertyaddress, CHARINDEX (',',propertyaddress)+1, len(PropertyAddress))




select  OwnerAddress
from NashvilleHousing

SELECT 
    PARSENAME(replace(OwnerAddress, ',', '.'), 3) AS OwnderSplitAddress
   , PARSENAME(replace(OwnerAddress, ',', '.'), 2) AS OwnderSplitCity
   , PARSENAME(replace(OwnerAddress, ',', '.'), 1) AS OwnderSplitState
FROM NashvilleHousing;


alter table NashvilleHousing
add OwnerSplitAddress nvarchar(255);
Update NashvilleHousing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress, ',', '.'), 3)

alter table NashvilleHousing
add OwnderSplitCity nvarchar(255);
Update NashvilleHousing
set OwnderSplitCity = PARSENAME(replace(OwnerAddress, ',', '.'), 2) 

alter table NashvilleHousing
add OwnderSplitState nvarchar(255);
Update NashvilleHousing
set OwnderSplitState = PARSENAME(replace(OwnerAddress, ',', '.'), 1) 

select *
from NashvilleHousing



--Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant

--Update NashvilleHousing
select SoldAsVacant,
case
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
End
from NashvilleHousing

Update NashvilleHousing
set SoldAsVacant = case
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
End


--Remove Duplicates
WITH RowNumCTE as (
select *,
row_number()over(partition by parcelID, propertyaddress,saleprice,saledate,legalreference order by uniqueID) as row_number
from NashvilleHousing)
select *
from RowNumCTE
where row_number>1


--Delete Unused Columns

Select *
from NashvilleHousing

alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

alter table NashvilleHousing
drop column SaleDate




















