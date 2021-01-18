tests=(mul mulh mulhsu div dep_m_ext WB_hazard)
./CI/scripts/run_list.sh $(echo ${tests[@]})
