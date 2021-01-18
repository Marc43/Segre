tests=(mul mulh mulhsu div dep_m_ext WB_hazard M_ext_D_EX_bypasses)
./CI/scripts/run_list.sh $(echo ${tests[@]})
