#pragma once
#include "spdlog/spdlog.h"
#include <cstddef>

namespace cpt::base {

/*! \addtogroup cpt
*  Additional documentation for group 'cpt'
*  @{
*/

/*! \addtogroup base
*  Additional documentation for group 'cpt::base'
*  @{
*/

/**
 * @class Log
 * @brief Logger wrapper for spdlog
 *
 *      fmtlib formatting is supported.
 *
 *      log_inf(fmt, ...)
 *      log_war(fmt, ...)
 *      log_err(fmt, ...)
 */
class Log
{
public:
    typedef spdlog::logger Logger;
    typedef spdlog::level::level_enum  LogLevel;

    /** get instance
    */
    static std::shared_ptr<Logger> get_logger()
    {
        if (!m_logger) {
            init(log_level);
        }
        return m_logger;
    }

private:
    static std::shared_ptr<Logger> m_logger;
    //TODO: change log level for debug
    static constexpr LogLevel log_level = LogLevel::debug;

    // Start logging to console and specified logfile. All messages below
    // the provided log level will be dropped.
    static void init(LogLevel level);
};

// Logging functions, fmtlib formatting is supported.
#define log_trc(fmt, ...) SPDLOG_LOGGER_TRACE(Log::get_logger() , fmt, ##__VA_ARGS__)
#define log_dbg(fmt, ...) SPDLOG_LOGGER_DEBUG(Log::get_logger() , fmt, ##__VA_ARGS__)
#define log_inf(fmt, ...) SPDLOG_LOGGER_INFO(Log::get_logger()  , fmt, ##__VA_ARGS__)
#define log_war(fmt, ...) SPDLOG_LOGGER_WARN(Log::get_logger()  , fmt, ##__VA_ARGS__)
#define log_err(fmt, ...) SPDLOG_LOGGER_ERROR(Log::get_logger() , fmt, ##__VA_ARGS__)
#define log_crt(fmt, ...) SPDLOG_LOGGER_CRITICAL(Log::get_logger()  , fmt, ##__VA_ARGS__)

/*! @} End of Doxygen Groups*/
/*! @} End of Doxygen Groups*/
} // namespace