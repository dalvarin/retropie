function resize_height () {
  echo "Filename: ${filename}"
  height=$(identify -format "%h" ${filename})
  if [ ${height} -gt 600 ]
  then
    echo "Picture height greater than 600px (${height}), do you want to resize to 600px? (Y/[N])"
    read resize
    if [ "${resize}" = "Y" ] || [ "${resize}" = "y" ]
    then
      convert ${filename} -resize 600x600 ${filename}
    fi
  fi
}

function resize_weight () {
  if [ ${size} -gt 102400 ]
  then
    echo "Picture size grater than 100KB (${size}), do you want to resize to less than 100KB (Y/[N])"
    read resize2
    if [ "${resize2}" = "Y" ] || [ "${resize2}" = "y" ]
    then
      convert ${filename} -define jpeg:extent=100kb ${filename}
    fi
  fi
}

function convert_to_jpg () {
  echo "Picture format is PNG (${filename}), do you want to convert it to JPG format? (Y/[N])"
  read rename
  if [ "${rename}" = "Y" ] || [ "${rename}" = "y" ]
  then
    convert ${filename} ${filename::-4}.jpg
    echo "Do you want to remove PNG file (${filename})? (Y/[N])"
    read delete
    if [ "${delete}" = "Y" ] || [ "${delete}" = "y" ]
    then
      rm -f ${filename}
    fi
    filename=${filename::-4}.jpg
  fi


}

for file in $(ls)
do

  if [ $(grep -c ${file} picnormalizer_exclude) -gt 0 ]
  then
    continue
  fi

  line=$(ls -l "${file}")
  filename=$(echo ${line} | awk '{print $9}')

  if [[ ${filename} =~ \.jpg ]]
  then

    resize_height

    size=$(echo ${line} | awk '{print $5}')

    resize_weight

  elif [[ ${filename} =~ \.png ]]
  then

    convert_to_jpg

    resize_height

    line=$(ls -l "${filename}")
    size=$(echo ${line} | awk '{print $5}')

    resize_weight

  fi

done